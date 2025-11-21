{{- $image := .Source.Target.UserInput -}}
{
  "version": "15.0.0",
  "scan": {
    "scanner": {
      "id": "grype",
      "name": "Grype",
      "url": "https://github.com/anchore/grype",
      "vendor": {
        "name": "Anchore"
      },
      "version": "{{ .Descriptor.Version }}"
    },
    "type": "container_scanning",
    "start_time": "{{ .Descriptor.Timestamp }}",
    "end_time": "{{ .Descriptor.Timestamp }}",
    "status": "success"
  },
  "vulnerabilities": [
  {{- $t_first := true }}
  {{- range .Matches }}
    {{- if $t_first -}}
      {{- $t_first = false -}}
    {{ else -}}
      ,
    {{- end }}
    {{- $fixedInVersion := "" -}}
    {{- if ge (len .Vulnerability.Fix.Versions) 1 -}}
      {{- $fixedInVersion = index .Vulnerability.Fix.Versions 0 -}}
    {{- end }}
    {
      "id": "{{ .Vulnerability.ID }}",
      "name": "{{ .Vulnerability.ID }}",
      "description": {{ .Vulnerability.Description | printf "%q" }},
      "severity": {{ if eq .Vulnerability.Severity "Negligible" }}"Low"{{ else if eq .Vulnerability.Severity "Unknown" }}"Unknown"{{ else }}"{{ .Vulnerability.Severity }}"{{ end }},
      "solution": {{ if $fixedInVersion }}"Upgrade {{ .Artifact.Name }} to version {{ $fixedInVersion }}"{{ else }}"No solution provided"{{ end }},
      "identifiers": [
        {
          "type": {{ if eq (substr 0 3 .Vulnerability.ID) "CVE" }}"cve"{{ else if eq (substr 0 4 .Vulnerability.ID) "GHSA" }}"ghsa"{{ else }}"cve"{{ end }},
          "name": "{{ .Vulnerability.ID }}",
          "value": "{{ .Vulnerability.ID }}"{{ if eq (substr 0 3 .Vulnerability.ID) "CVE" }},
          "url": "https://nvd.nist.gov/vuln/detail/{{ .Vulnerability.ID }}"{{ else if eq (substr 0 4 .Vulnerability.ID) "GHSA" }},
          "url": "https://github.com/advisories/{{ .Vulnerability.ID }}"{{ end }}
        }
      ],
      "links": [
        {{- if gt (len .Vulnerability.URLs) 0 -}}
        {{- $lastIdx := getLastIndex .Vulnerability.URLs -}}
        {{- range $j, $url := .Vulnerability.URLs }}
        {"url": "{{ $url }}"}{{if ne $lastIdx $j}},{{end}}
        {{- end -}}
        {{- else }}
        {"url": ""}
        {{- end }}
      ],
      "location": {
        "dependency": {
          "package": {
            "name": "{{ .Artifact.Name }}"
          },
          "version": "{{ .Artifact.Version }}"
        },
        "operating_system": "{{ .Artifact.Type }}",
        "image": "{{ $image }}"
      }
    }
  {{- end }}
  ]
}