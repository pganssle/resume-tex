from . import resume_builder
from pathlib import Path
import os
import re

def get_event_details(talk):
    name = None
    location = None

    if 'conference' in talk:
        event = talk['conference']
        name = event['name']

        if 'year' in event:
            name += f' {event["year"]}'
    elif 'meetup' in talk:
        event = talk['meetup']
        name = ''
        if 'name' in event:
            name += f'{event["name"]}'

        if 'event' in event:
            if name:
                name += ' - '

            name += event['event']

        if not name:
            name = None
    elif 'event' in talk:
        event = talk['event']
        name = event['name']

    location = event['location']

    return name, location


def slice_values(values, subset):
    """
    Overload the slicing concept to allow YAML-storable values to be used
    as slices.

    If subset is a:

        ``bool``: Return the entire list for ``True``, nothing for ``False``
        ``int``: Return ``values[0:subset]``
        ``list`` or ``tuple`` of length 2: Return ``values[subset[0]:subset[1]]``
    """
    if isinstance(subset, bool):
        if subset:
            return values
        else:
            return []

    if isinstance(subset, int):
        subset = (0, subset)

    if isinstance(subset, (list, tuple)):
        assert len(subset) == 2
        return values[subset[0]:subset[1]]

    raise TypeError(f"Cannot process subset of class {type(subset).__name__}")


SPECIAL_CHARS = re.compile(r'([\\&%$#_{}~^])')
def latex_escape(s):
    # Make all special characters literals
    return SPECIAL_CHARS.sub(r'\\\1', s)


def main():
    builder = resume_builder.ResumeBuilder(
        custom_funcs={'get_event_details': get_event_details,
                      'slice_values': slice_values,
                      'latex_escape': latex_escape,
                      'any': any,
                      'all': all}
    )
    builder.write()
