#!/bin/bash

for n in {26..126}; do
    let k=n-26
    mv -nv relief_video_0_-$n.png relief_video_0_-$k.png
done
