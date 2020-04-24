def box_capacity(length, width, height):
    inches_length = length*12
    inches_width = width*12
    inches_height = height*12
    return (inches_length//16) * (inches_width//16) * (inches_height//16)