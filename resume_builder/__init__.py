from . import resume_builder
from . import custom_funcs


def main():
    builder = resume_builder.ResumeBuilder(
        custom_funcs=custom_funcs.get_custom_funcs(),
    )
    builder.write()
