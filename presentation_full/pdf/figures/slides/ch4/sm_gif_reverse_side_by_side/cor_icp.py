#https://nbviewer.org/github/niosus/notebooks/blob/master/icp.ipynb#Using-point-to-plane-metric-with-Least-Squares-ICP
#https://github.com/niosus/

import sys
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import animation, rc
from math import sin, cos, atan2, pi
from IPython.display import display, Math, Latex, HTML
from sympy import init_printing, symbols, Matrix, cos as s_cos, sin as s_sin, diff
init_printing(use_unicode = True)
from functools import partial
from sm_noise0 import sm_noise0
from sm_noise10 import sm_noise10
from sm_noise0_reverse import sm_noise0_reverse

################################################################################
def plot_data(data_1, data_2, label_1, label_2, markersize_1=8, markersize_2=8):
    fig = plt.figure(figsize=(10, 6))
    ax = fig.add_subplot(111)
    ax.axis('equal')
    if data_1 is not None:
        x_p, y_p = data_1
        ax.plot(x_p, y_p, color='#336699', markersize=markersize_1, marker='o', linestyle=":", label=label_1)
    if data_2 is not None:
        x_q, y_q = data_2
        ax.plot(x_q, y_q, color='orangered', markersize=markersize_2, marker='o', linestyle=":", label=label_2)
    ax.legend()
    return ax

################################################################################
def plot_values(values, label):
    fig = plt.figure(figsize=(10, 4))
    ax = fig.add_subplot(111)
    ax.plot(values, label=label)
    ax.legend()
    ax.grid(True)
    plt.show()

################################################################################
def animate_results(P_values, Q, corresp_values, xlim, ylim):
    """A function used to animate the iterative processes we use."""
    fig, anim_ax1 = plt.subplots(1,1,figsize=(1600/96, 900/96), dpi=96)

    anim_ax1.set(xlim=xlim, ylim=ylim)
    anim_ax1.set_aspect('equal')
    #anim_ax2.set_aspect('equal')
    #anim_ax2.get_xaxis().set_visible(False)
    #anim_ax2.get_yaxis().set_visible(False)

    x_q, y_q = Q
    # draw initial correspondeces
    corresp_lines = []
    for i, j in correspondences:
        corresp_lines.append(anim_ax1.plot([], [], 'grey')[0])
    # Prepare Q data.
    Q_line, = anim_ax1.plot(x_q, y_q, 'o', color='orangered')
    # prepare empty line for moved data
    P_line, = anim_ax1.plot([], [], 'o', color='#336699')

    num_points = len(corresp_values[0])
    #M = anim_ax2.imshow(np.empty((num_points, num_points)), cmap='hot', interpolation='nearest')

    l = (P_line,)


    def animate(i):
        P_inc = P_values[i]
        x_p, y_p = P_inc
        P_line.set_data(x_p, y_p)
        draw_inc_corresp(P_inc, Q, corresp_values[i])

        #M.set_data(get_heatmap_matrix(corresp_values[i]))
        l = (P_line,)

        plt.savefig('/media/li9i/var2/elements/PhD/dissertation/presentation/pdf/figures/slides/ch4/sm_gif_reverse_side_by_side/pic'+str(i)+'.png', bbox_inches='tight')

        return l

    def draw_inc_corresp(points_from, points_to, correspondences):
        for corr_idx, (i, j) in enumerate(correspondences):
            x = [points_from[0, i], points_to[0, j]]
            y = [points_from[1, i], points_to[1, j]]
            corresp_lines[corr_idx].set_data(x, y)

    anim = animation.FuncAnimation(fig, animate,
                                   frames=len(P_values),
                                   interval=500,
                                   blit=True)
    f = r"/media/li9i/var2/elements/PhD/dissertation/presentation/pdf/figures/slides/ch4/sm_gif_reverse_side_by_side/animation.gif"
    writergif = animation.PillowWriter(fps=5)
    anim.save(f, writer=writergif)

    return HTML(anim.to_jshtml())

################################################################################
def get_correspondence_indices(P, Q):
    """For each point in P find closest one in Q."""
    p_size = P.shape[1]
    q_size = Q.shape[1]
    correspondences = []
    for i in range(p_size):
        p_point = P[:, i]
        min_dist = sys.maxsize
        chosen_idx = -1
        for j in range(q_size):
            q_point = Q[:, j]
            dist = np.linalg.norm(q_point - p_point)
            if dist < min_dist:
                min_dist = dist
                chosen_idx = j
        correspondences.append((i, chosen_idx))
    return correspondences

################################################################################
def draw_correspondeces(P, Q, correspondences, ax):
    label_added = False
    for i, j in correspondences:
        x = [P[0, i], Q[0, j]]
        y = [P[1, i], Q[1, j]]
        if not label_added:
            ax.plot(x, y, color='grey', label='correpondences')
            label_added = True
        else:
            ax.plot(x, y, color='grey')
    ax.legend()

################################################################################
def center_data(data, exclude_indices=[]):
    reduced_data = np.delete(data, exclude_indices, axis=1)
    center = np.array([reduced_data.mean(axis=1)]).T
    return center, data - center

################################################################################
def compute_cross_covariance(P, Q, correspondences, kernel=lambda diff: 1.0):
    cov = np.zeros((2, 2))
    exclude_indices = []
    for i, j in correspondences:
        p_point = P[:, [i]]
        q_point = Q[:, [j]]
        weight = kernel(p_point - q_point)
        if weight < 0.01: exclude_indices.append(i)
        cov += weight * q_point.dot(p_point.T)
    return cov, exclude_indices

################################################################################
def icp_svd(P, Q, iterations=50, kernel=lambda diff: 1.0):
    """Perform ICP using SVD."""
    center_of_Q, Q_centered = center_data(Q)
    norm_values = []
    P_values = [P.copy()]
    P_copy = P.copy()
    corresp_values = []
    exclude_indices = []
    for i in range(iterations):
        center_of_P, P_centered = center_data(P_copy, exclude_indices=exclude_indices)
        correspondences = get_correspondence_indices(P_centered, Q_centered)
        corresp_values.append(correspondences)
        norm_values.append(np.linalg.norm(P_centered - Q_centered))
        cov, exclude_indices = compute_cross_covariance(P_centered, Q_centered, correspondences, kernel)
        U, S, V_T = np.linalg.svd(cov)
        R = U.dot(V_T)
        t = center_of_Q - R.dot(center_of_P)
        P_copy = R.dot(P_copy) + t
        P_values.append(P_copy)
    corresp_values.append(corresp_values[-1])
    return P_values, norm_values, corresp_values

################################################################################
def dR(theta):
    return np.array([[-sin(theta), -cos(theta)],
                     [cos(theta),  -sin(theta)]])

################################################################################
def R(theta):
    return np.array([[cos(theta), -sin(theta)],
                     [sin(theta),  cos(theta)]])

################################################################################
def jacobian(x, p_point):
    theta = x[2]
    J = np.zeros((2, 3))
    J[0:2, 0:2] = np.identity(2)
    J[0:2, [2]] = dR(0).dot(p_point)
    return J

################################################################################
def error(x, p_point, q_point):
    rotation = R(x[2])
    translation = x[0:2]
    prediction = rotation.dot(p_point) + translation
    return prediction - q_point


################################################################################
def prepare_system_normals(x, P, Q, correspondences, Q_normals):
    H = np.zeros((3, 3))
    g = np.zeros((3, 1))
    chi = 0
    for i, j in correspondences:
        p_point = P[:, [i]]
        q_point = Q[:, [j]]
        normal = Q_normals[j]
        e = normal.dot(error(x, p_point, q_point))
        J = normal.dot(jacobian(x, p_point))
        H += J.T.dot(J)
        g += J.T.dot(e)
        chi += e.T * e
    return H, g, chi

################################################################################
def prepare_system(x, P, Q, correspondences, kernel=lambda distance: 1.0):
    H = np.zeros((3, 3))
    g = np.zeros((3, 1))
    chi = 0
    for i, j in correspondences:
        p_point = P[:, [i]]
        q_point = Q[:, [j]]
        e = error(x, p_point, q_point)
        weight = kernel(e) # Please ignore this weight until you reach the end of the notebook.
        J = jacobian(x, p_point)
        H += weight * J.T.dot(J)
        g += weight * J.T.dot(e)
        chi += e.T * e
    return H, g, chi

################################################################################
def icp_least_squares(P, Q, iterations=50, kernel=lambda distance: 1.0):
    x = np.zeros((3, 1))
    chi_values = []
    x_values = [x.copy()]  # Initial value for transformation.
    P_values = [P.copy()]
    P_copy = P.copy()
    corresp_values = []
    for i in range(iterations):
        rot = R(x[2])
        t = x[0:2]
        correspondences = get_correspondence_indices(P_copy, Q)
        corresp_values.append(correspondences)
        H, g, chi = prepare_system(x, P, Q, correspondences, kernel)
        dx = np.linalg.lstsq(H, -g, rcond=None)[0]
        x += dx
        x[2] = atan2(sin(x[2]), cos(x[2])) # normalize angle
        chi_values.append(chi.item(0))
        x_values.append(x.copy())
        rot = R(x[2])
        t = x[0:2]
        P_copy = rot.dot(P.copy()) + t
        print rot, t
        P_values.append(P_copy)
    corresp_values.append(corresp_values[-1])
    return P_values, chi_values, corresp_values


################################################################################
def compute_normals(points, step=1):
    normals = [np.array([[0, 0]])]
    normals_at_points = []
    for i in range(step, points.shape[1] - step):
        prev_point = points[:, i - step]
        next_point = points[:, i + step]
        curr_point = points[:, i]
        dx = next_point[0] - prev_point[0]
        dy = next_point[1] - prev_point[1]
        normal = np.array([[0, 0],[-dy, dx]])
        normal = normal / np.linalg.norm(normal)
        normals.append(normal[[1], :])
        normals_at_points.append(normal + curr_point)
    normals.append(np.array([[0, 0]]))
    return normals, normals_at_points

################################################################################
def plot_normals(normals, ax):
    label_added = False
    for normal in normals:
        if not label_added:
            ax.plot(normal[:,0], normal[:,1], color='grey', label='normals')
            label_added = True
        else:
            ax.plot(normal[:,0], normal[:,1], color='grey')
    ax.legend()
    return ax

################################################################################
def RotationMatrix(angle):
    return Matrix([[s_cos(angle) , -s_sin(angle)], [s_sin(angle), s_cos(angle)]])

################################################################################
def icp_normal(P, Q, Q_normals, iterations=50):
    x = np.zeros((3, 1))
    chi_values = []
    x_values = [x.copy()]  # Initial value for transformation.
    P_values = [P.copy()]
    P_latest = P.copy()
    corresp_values = []
    for i in range(iterations):
        rot = R(x[2])
        t = x[0:2]
        correspondences = get_correspondence_indices(P_latest, Q)
        corresp_values.append(correspondences)
        H, g, chi = prepare_system_normals(x, P, Q, correspondences, Q_normals)
        dx = np.linalg.lstsq(H, -g, rcond=None)[0]
        x += dx
        x[2] = atan2(sin(x[2]), cos(x[2])) # normalize angle
        chi_values.append(chi.item(0)) # add error to list of errors
        x_values.append(x.copy())
        rot = R(x[2])
        t = x[0:2]
        P_latest = rot.dot(P.copy()) + t
        P_values.append(P_latest)
    corresp_values.append(corresp_values[-1])
    return P_values, chi_values, corresp_values


################################################################################
def kernel(threshold, error):
    if np.linalg.norm(error) < threshold:
        return 1.0
    return 0.0

################################################################################
def get_heatmap_matrix(corresp_values_i):
  num_points = len(corresp_values_i)
  cc = np.zeros((num_points, num_points))

  for cv in corresp_values_i:
    cc[cv] = 1

#    if cv[0] > 0 and cv[0] < num_points-1:
      #if cv[1] > 0 and cv[1] < num_points-1:
        #cc[cv[0]+1,cv[1]] = 1
        #cc[cv[0]+1,cv[1]+1] = 1
        #cc[cv[0]+1,cv[1]-1] = 1

        #cc[cv[0]-1,cv[1]] = 1
        #cc[cv[0]-1,cv[1]+1] = 1
        #cc[cv[0]-1,cv[1]-1] = 1

        #cc[cv[0],cv[1]] = 1
        #cc[cv[0],cv[1]+1] = 1
        #cc[cv[0],cv[1]-1] = 1




  return cc






################################################################################
################################################################################




# Generate data as a list of 2d points
num_points = 360
true_data = np.zeros((2, num_points))

# Move the data
moved_data = np.zeros((2, num_points))

###########
# Final error (5.0559e-06,0.0022485,0.0059100) i.e. (0.0022485, 0.0059100)
#sm_noise0(true_data,moved_data)

# Final error (0.027015,0.022117,0.0111) i.e. (0.034914,0.0111)
#sm_noise10(true_data,moved_data)

# Final error () i.e. ()
sm_noise0_reverse(true_data,moved_data)


# Assign to variables we use in formulas.

# for sigma 0 and 10
#P = true_data
#Q = moved_data

# for reverse
#Q = true_data
#P = moved_data

P = true_data
Q = moved_data

plot_data(moved_data, true_data, "P: moved data", "Q: true data")
plt.show()








center_of_P_outliers = np.array([P.mean(axis=1)]).T
center_of_Q = np.array([Q.mean(axis=1)]).T
P_centered_outliers = P- center_of_P_outliers
Q_centered = Q - center_of_Q

correspondences = get_correspondence_indices(P_centered_outliers, Q_centered)


xlim_lo = np.minimum(np.amin(true_data[0,:]),np.amin(moved_data[0,:]))
xlim_hi = np.maximum(np.amax(true_data[0,:]),np.amax(moved_data[0,:]))

ylim_lo = np.minimum(np.amin(true_data[1,:]),np.amin(moved_data[1,:]))
ylim_hi = np.maximum(np.amax(true_data[1,:]),np.amax(moved_data[1,:]))

P_values, chi_values, corresp_values = icp_least_squares(
    P, Q, kernel=partial(kernel, 10))
plot_values(chi_values, label="chi^2")
animate_results(P_values, Q, corresp_values, xlim=(xlim_lo-0.5,xlim_hi+0.5), ylim=(ylim_lo-0.5,ylim_hi+0.5))





#for c in corresp_values:
  #cc = get_heatmap_matrix(c)
  #plt.imshow(cc, cmap='hot', interpolation='nearest')
  #plt.show()
