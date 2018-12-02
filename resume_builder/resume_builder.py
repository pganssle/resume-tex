import jinja2
import yaml

from pathlib import Path
from dataclasses import dataclass

@dataclass
class ResumeBuilder:
    base_path: Path = '.'
    tex_dir : Path = Path('tex')
    template_file : Path = Path('resume.tex')
    out_dir : Path = Path('output')
    out_file : Path = None
    data_dir : Path = Path('data')
    cv_contents_file : Path = Path('cv_contents.yml')
    personal_data_file : Path = Path('personal_data.yml')

    def __post_init__(self):
        self._cache = {}
        if self.out_file is None:
            out = self.template_file
            if out.suffix == '.tpl':
                out = out.with_suffix('')

                if not out.suffix:
                    out = out.with_suffix('.tex')

            self.out_file = out

    @property
    def tex_path(self):
        return self.base_path / self.tex_dir

    @property
    def data_path(self):
        return self.base_path / self.data_dir

    @property
    def template_path(self):
        return self.tex_path / self.template_file

    @property
    def cv_contents_path(self):
        return self.data_path / self.cv_contents_file

    @property
    def personal_data_path(self):
        return self.data_path / self.personal_data_file

    @property
    def output_path(self):
        return self.base_path / self.out_dir / self.out_file

    @property
    def jinja_env(self):
        return self._cache.setdefault('jinja_env',
            jinja2.Environment(
                block_start_string = '\BLOCK{',
                block_end_string = '}',
                variable_start_string = '\VAR{',
                variable_end_string = '}',
                comment_start_string = '\#{',
                comment_end_string = '}',
                line_statement_prefix = '%%',
                line_comment_prefix = '%#',
                trim_blocks = True,
                autoescape = False,
                loader=jinja2.FileSystemLoader([self.tex_path]),
            )
        )

    @property
    def template(self):
        return self._cache.setdefault('template',
            self.jinja_env.get_template(str(self.template_file))
            )

    def load_inputs(self):
        inputs = {
            'metadata': self._load_yaml(self.personal_data_path),
            'cvdata': self._load_yaml(self.cv_contents_path),
        }

        return inputs

    def render(self):
        kwargs = self.load_inputs()

        return self.template.render(**kwargs)

    def write(self):
        self.output_path.parent.mkdir(exist_ok=True, parents=True)
        with open(self.output_path, 'wt') as f:
            rendered_text = self.render()
            f.write(rendered_text)

    def _load_yaml(self, fpath):
        with open(fpath) as f:
            return yaml.safe_load(f)

