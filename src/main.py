from pathlib import Path
from litestar import Litestar, get
from litestar.response import Template
from litestar.contrib.jinja import JinjaTemplateEngine
from litestar.template.config import TemplateConfig
from litestar.static_files import create_static_files_router

ASSETS_DIR = Path("public")

def on_startup():
    ASSETS_DIR.mkdir(exist_ok=True)

@get("/")
async def index() -> Template:
    return Template(template_name="index.html")

template_config = TemplateConfig(
    directory=Path("templates"),
    engine=JinjaTemplateEngine
)

app = Litestar(route_handlers=[index, create_static_files_router(path="/", directories=["public"])], template_config=template_config)