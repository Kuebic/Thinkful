def guess_blue(blue_start, red_start, blue_pulled, red_pulled):
    blue_left = blue_start - blue_pulled
    red_left = red_start - red_pulled
    return blue_left / (blue_left + red_left)