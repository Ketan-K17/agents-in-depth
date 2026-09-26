import json

from tools import ToolRegistry


def test_parse_pdf_is_registered_with_its_schema():
    registry = ToolRegistry()

    schema_by_name = {
        schema["function"]["name"]: schema["function"]
        for schema in registry.get_tool_schemas()
    }

    assert "parse_pdf" in schema_by_name
    assert schema_by_name["parse_pdf"]["parameters"] == {
        "type": "object",
        "properties": {
            "url": {
                "type": "string",
                "description": "A PDF URL, a file:// URL, or a local file path."
            }
        },
        "required": ["url"],
    }


def test_parse_pdf_is_executable_from_the_registry():
    registry = ToolRegistry()

    result = json.loads(
        registry.execute_tool("parse_pdf", {"url": "/definitely/not/a/real.pdf"})
    )

    assert result["success"] is False
    assert "error" in result
