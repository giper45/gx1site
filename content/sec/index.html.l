{{ define "main" }}
  <article>
    <h1>Security posts</h1>
    <br/>
    <h3 class="text-center"> <a href="/about"> Who am I? </a> </h3>

    <ul class="posts-list">
      {{ range where (where .Paginator.Pages "Type" "!=" "page") "Permalink" "intersect" "/security" }}

        <li class="posts-list-item">
          <a class="posts-list-item-title" href="{{ .Permalink }}">{{ .Title }}</a>
          <span class="posts-list-item-description">
            {{ partial "icon.html" (dict "ctx" $ "name" "calendar") }}
            {{ .PublishDate.Format "Jan 2, 2006" }}
            <span class="posts-list-item-separator">-</span>
            {{ partial "icon.html" (dict "ctx" $ "name" "clock") }}
            {{ .ReadingTime }} min read
          </span>
        </li>
      {{ end }}
    </ul>
    {{ partial "pagination.html" $ }}
  </article>
{{ end }}