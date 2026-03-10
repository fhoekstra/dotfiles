return {
  "yetone/avante.nvim",
  opts = {
    providers = {
      mistral = {
        __inherited_from = "openai",
        api_key_name = "MISTRAL_API_KEY",
        endpoint = "https://api.mistral.ai/v1/",
        extra_request_body = {
          max_tokens = 4096, -- to avoid using max_completion_tokens
        },
        model = "mistral-large-latest",
      },
      mistral_medium = {
        __inherited_from = "openai",
        api_key_name = "MISTRAL_API_KEY",
        endpoint = "https://api.mistral.ai/v1/",
        extra_request_body = {
          max_tokens = 4096, -- to avoid using max_completion_tokens
        },
        model = "mistral-medium-latest",
      },
      mistral_devstral = {
        __inherited_from = "openai",
        api_key_name = "MISTRAL_API_KEY",
        endpoint = "https://api.mistral.ai/v1/",
        extra_request_body = {
          max_tokens = 4096, -- to avoid using max_completion_tokens
        },
        model = "devstral-medium-latest",
      },
      mistral_devstral_small = {
        __inherited_from = "openai",
        api_key_name = "MISTRAL_API_KEY",
        endpoint = "https://api.mistral.ai/v1/",
        extra_request_body = {
          max_tokens = 4096, -- to avoid using max_completion_tokens
        },
        model = "devstral-small-latest",
      },
      mistral_codestral = {
        __inherited_from = "openai",
        api_key_name = "MISTRAL_API_KEY",
        endpoint = "https://api.mistral.ai/v1/",
        extra_request_body = {
          max_tokens = 4096, -- to avoid using max_completion_tokens
        },
        model = "codestral-latest",
      },
    },
  },
}
