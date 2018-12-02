from . import resume_builder
from pathlib import Path
import os

def main():
    builder = resume_builder.ResumeBuilder()
    builder.write()
