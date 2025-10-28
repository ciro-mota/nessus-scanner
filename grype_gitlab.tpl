{{- $image := .Source.Target.UserInput -}}
{
  "version": "15.0.0",
  "vulnerabilities": [
  {{- $t_first := true }}
  {{- range .Matches }}
    {{- if $t_first -}}
      {{- $t_first = false -}}
    {{ else -}}
      ,
    {{- end }}
    {{- $fixedInVersion := "" -}}
    {{- if ge (len .Vulnerability.Fix.Versions) 1 -}}{{- $fixedInVersion = index .Vulnerability.Fix.Versions 0 -}}{{- end }}
    {
      "id": "{{ .Vulnerability.ID }}",
      "name": "{{ .Vulnerability.ID }}",
      "description": {{ .Vulnerability.Description | printf "%q" }},
      "severity": {{ if eq .Vulnerability.Severity "Negligible" -}}
                    "Low"
                  {{- else if eq .Vulnerability.Severity "Unknown" -}}
                    "Unknown"
                  {{- else -}}
                    "{{ .Vulnerability.Severity }}"
                  {{- end }},
      "solution": {{ if $fixedInVersion -}}
                    "Upgrade {{ .Artifact.Name }} to version {{ $fixedInVersion }}"
                  {{- else -}}
                    "No solution provided"
                  {{- end }},
      "identifiers": [
        {{- if eq (substr 0 3 .Vulnerability.ID) "CVE" }}
        {
          "type": "cve",
          "name": "{{ .Vulnerability.ID }}",
          "value": "{{ .Vulnerability.ID }}",
          "url": "https://nvd.nist.gov/vuln/detail/{{ .Vulnerability.ID }}"
        }
        {{- else if eq (substr 0 4 .Vulnerability.ID) "GHSA" }}
        {
          "type": "ghsa",
          "name": "{{ .Vulnerability.ID }}",
          "value": "{{ .Vulnerability.ID }}",
          "url": "https://github.com/advisories/{{ .Vulnerability.ID }}"
        }
        {{- else }}
        {
          "type": "other",
          "name": "{{ .Vulnerability.ID }}",
          "value": "{{ .Vulnerability.ID }}"
        }
        {{- end }}
      ],
      "links": [
        {{- $lastIndexOfURLs := getLastIndex .Vulnerability.URLs -}}
        {{- if gt (len .Vulnerability.URLs) 0 -}}
        {{- range $j, $url := .Vulnerability.URLs }}
        {
          "url": "{{ $url }}"
        }{{if ne $lastIndexOfURLs $j}},{{end}}
        {{- end -}}
        {{- else }}
        {
          "url": ""
        }
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
  ],
  "remediations": [],
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
  }
}