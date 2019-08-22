def greet_jedi(first, last):
    new_name = last[:3].capitalize() + first[:2].capitalize()
    return 'Greetings, master {}'.format(new_name)