def area_code(text):
    location = text.find('(')
    return text[location+1:location+4]