import re
import itertools as it
from html import parser

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
        return it.islice(values, subset[0], subset[1])

    raise TypeError(f"Cannot process subset of class {type(subset).__name__}")


SPECIAL_CHARS = re.compile(r'([\\&%$#_{}~^])')
def latex_escape(s):
    # Make all special characters literals
    return SPECIAL_CHARS.sub(r'\\\1', s)


class HTML2LatexParser(parser.HTMLParser):
    TAGS = {
        "sup": (r"\textsuperscript{", "}"),
        "sub": (r"\textsubscript{", "}"),
        "em": (r"\textit{", "}"),
        "b": (r"\textbf{", "}"),
    }

    def convert(self, s):
        self.__latex = ""
        self._tag_stack = []
        self.feed(s)
        latex = self.__latex
        self.__latex = ""
        return latex

    def handle_starttag(self, tag, attrs):
        if tag not in self.TAGS:
            raise ValueError(f"Cannot convert tag {tag}")

        if attrs:
            raise ValueError(f"Cannot handle attrs for tag {tag}: {attrs}")

        self.__latex += self.TAGS[tag][0]
        self._tag_stack.append(tag)

    def handle_endtag(self, tag):
        assert tag == self._tag_stack.pop()

        self.__latex += self.TAGS[tag][1]

    def handle_data(self, data):
        self.__latex += data


def html2latex(s):
    return HTML2LatexParser().convert(s)

def get_custom_funcs():
    funcs = [
        'get_event_details',
        'slice_values',
        'latex_escape',
        'html2latex',
    ]

    GLOBAL_VALS = globals()
    cfm = {k: GLOBAL_VALS.get(k) for k in funcs}

    # Add some builtins
    cfm.update({'any': any, 'all': all})

    return cfm
