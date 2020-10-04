"""
Script untuk memanage CONTRIBUTOR.md FILE
"""
import re

def format_contributor(contrib):
    """
    Helper function to format the details properly.
    """
    name_str = 'Name: ['
    contrib = contrib.replace('：', ':')
    contrib = contrib.replace('htpps', 'https')
    contrib = contrib.replace('Name:[', name_str)
    contrib = contrib.replace('Name : [', name_str)
    contrib = contrib.replace('Name :[', name_str)
    contrib = contrib.replace('Name: [ ', name_str)
    contrib= '#### ' + contrib+ '\n\n'
    return contrib


with open('CONTRIBUTORS.md', 'r+') as file:
    new_file_data = []
    for line in file.readlines():
        line = re.sub('^#{1,3} ', '#### ', line)
        if(line.startswith(' ##')):
            new_file_data.append(line.lstrip())
        else:
            new_file_data.append(line)
    file.seek(0)
    file.truncate()
    file.writelines(new_file_data)


with open('CONTRIBUTORS.md', 'r+') as file:
    contributors = [contributor.strip() for contributor in file.read().split('####')
                                if contributor]
    contributors = [format_contributor(contrib) for contrib in contributors]
    contributors = sorted(contributors)
    file.seek(0)
    file.truncate()
    file.writelines(contributors)
