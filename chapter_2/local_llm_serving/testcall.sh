curl -s http://localhost:11434/api/chat -d @- <<'JSON' | python -m json.tool
{
  "model": "qwen3:0.6b",
  "stream": false,
  "think": true,
  "options": {
    "temperature": 0.3
  },
  "messages": [
    {
      "role": "user",
      "content": "What's 15 * 2?"
    }
  ],
  "tools": [
    {
      "type": "function",
      "function": {
        "name": "get_current_temperature",
        "description": "Get the current temperature for a specific location",
        "parameters": {
          "type": "object",
          "properties": {
            "location": {
              "type": "string",
              "description": "The city and country, e.g., 'Paris, France'"
            },
            "unit": {
              "type": "string",
              "enum": ["celsius", "fahrenheit"],
              "description": "The temperature unit to use (by default, celsius)"
            }
          },
          "required": ["location", "unit"]
        }
      }
    },
    {
      "type": "function",
      "function": {
        "name": "get_current_time",
        "description": "Get the current date and time in a specific timezone",
        "parameters": {
          "type": "object",
          "properties": {
            "timezone": {
              "type": "string",
              "description": "Timezone name (e.g., 'America/New_York', 'Europe/London', 'Asia/Tokyo'). Use standard IANA timezone names.",
              "default": "UTC"
            }
          },
          "required": []
        }
      }
    },
    {
      "type": "function",
      "function": {
        "name": "convert_currency",
        "description": "Convert an amount from one currency to another. You MUST use this tool to convert currencies in order to get the latest exchange rate.",
        "parameters": {
          "type": "object",
          "properties": {
            "amount": {
              "type": "number",
              "description": "Amount to convert"
            },
            "from_currency": {
              "type": "string",
              "description": "Source currency code (e.g., 'USD', 'EUR')"
            },
            "to_currency": {
              "type": "string",
              "description": "Target currency code (e.g., 'USD', 'EUR')"
            }
          },
          "required": ["amount", "from_currency", "to_currency"]
        }
      }
    },
    {
      "type": "function",
      "function": {
        "name": "parse_pdf",
        "description": "Extract text from a PDF available at a URL or local file path.",
        "parameters": {
          "type": "object",
          "properties": {
            "url": {
              "type": "string",
              "description": "A PDF URL, a file:// URL, or a local file path."
            }
          },
          "required": ["url"]
        }
      }
    },
    {
      "type": "function",
      "function": {
        "name": "code_interpreter",
        "description": "Execute Python code for calculations and data processing. You MUST use this tool to perform any complex calculations or data processing.",
        "parameters": {
          "type": "object",
          "properties": {
            "code": {
              "type": "string",
              "description": "Python code to execute. Use Python operators: ** for exponentiation (2 ** 10), not ^ — in Python ^ is bitwise XOR."
            }
          },
          "required": ["code"]
        }
      }
    }
  ]
}