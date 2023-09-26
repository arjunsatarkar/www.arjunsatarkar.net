defmodule WwwArjunsatarkarNet.Helpers do
  @spec generate_head_tags(binary, binary | nil, binary | nil) :: binary
  def generate_head_tags(title, canonical_url \\ nil, description \\ nil) do
    result =
      """
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">

          <title>#{title}</title>

          <link rel="stylesheet" href="/static/styles/main.css">
          <link rel="icon" href="/static/media/favicon.svg" type="image/svg+xml">
      """

    result =
      result <>
        if canonical_url != nil do
          result <>
            """
                <link rel="canonical" href="#{canonical_url}">

                <meta property="og:url" content="#{canonical_url}">
                <meta property="og:title" content="#{title}">
                <meta property="og:type" content="website">
                <meta property="og:image" content="https://www.arjunsatarkar.net/static/media/favicon.png">
            """
        else
          ""
        end

    result =
      result <>
        if description != nil do
          """
              <meta name="description" content="#{description}">
          """ <>
            if canonical_url != nil do
              """
                  <meta property="og:description" content="#{description}">
              """
            else
              ""
            end
        else
          ""
        end

    result
  end
end
