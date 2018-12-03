from . import resume_builder
from pathlib import Path
import os

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


def main():
    builder = resume_builder.ResumeBuilder(
        custom_funcs={'get_event_details': get_event_details}
    )
    builder.write()
