{{- $image := .Source.Target.UserInput }}
{
  "vulnerabilities": [
  {{- $t_first := true }}
  {{- range $i, $_ := .Matches }}
    {{- if $t_first -}}
      {{- $t_first = false -}}
    {{ else -}}
      ,
    {{- end }}
    {{- $fixedInVersion := "" -}}
    {{- if ge (len .Vulnerability.Fix.Versions) 1 -}}{{- $fixedInVersion = index .Vulnerability.Fix.Versions 0 -}}{{- end -}}
    {
      "language": "{{ .Artifact.Language }}",
      "category": "container_scanning",
      "message": "{{ .Vulnerability.ID }} in {{ .Artifact.Name }}-{{ .Artifact.Version }}",
      "description": {{ .Vulnerability.Description | printf "%q" }},
      "cve": "{{ .Vulnerability.ID }}",
      "severity": {{ if eq .Vulnerability.Severity "Negligible" -}}
                    "Low" {{- /* Since GitLab lacks a 'negligible' severity, 'Low' was the closest value in meaning. */ -}}
                  {{- else -}}
                    "{{ .Vulnerability.Severity }}"
                  {{- end }},
      "confidence": "Unknown",
      "remediateMetadata": {{ if not $fixedInVersion -}} {} {{- else -}}
      {
        "package_name": "{{ .Artifact.Name }}",
        "package_version": "{{ .Artifact.Version }}",
        "fixed_version": "{{ $fixedInVersion }}",
        "summary": "Upgrade {{ .Artifact.Name }} to {{ $fixedInVersion }}"
      }
      {{- end }},
      "solution": {{ if $fixedInVersion -}}
                    "Upgrade {{ .Artifact.Name }} to {{ $fixedInVersion }}"
                  {{- else -}}
                    "No solution provided"
                  {{- end }},
      "scanner": {
        "id": "grype",
        "name": "grype"
      },
      "location": {
        "dependency": {
          "package": {
            "name": "{{ .Artifact.Name }}"
          },
          "version": "{{ .Artifact.Version }}"
        },
        "operating_system": "{{ .Vulnerability.Namespace }}",
        "image": "{{ $image }}"
      },
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
        {{- else if eq (substr 0 4 .Vulnerability.ID) "ALAS" }}
        {
          "type": "alas",
          "name": "{{ .Vulnerability.ID }}",
          "value": "{{ .Vulnerability.ID }}",
          "url": "https://alas.aws.amazon.com/AL2/{{ .Vulnerability.ID }}.html"
        }
        {{- else if eq (substr 0 4 .Vulnerability.ID) "ELSA" }}
        {
          "type": "elsa",
          "name": "{{ .Vulnerability.ID }}",
          "value": "{{ .Vulnerability.ID }}",
          "url": "https://linux.oracle.com/errata/{{ .Vulnerability.ID }}.html"
        }
        {{- end }}
      ],
      "links": [
        {{- $lastIndexOfURLs := getLastIndex .Vulnerability.URLs}}
        {{- range $j, $_ := .Vulnerability.URLs }}
        {
          "url": "{{ . }}"
        }{{if ne $lastIndexOfURLs $j}},{{end}}
        {{- end }}
      ]
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
        "name": "GitLab"
      },
      "version": "0.34.3"
    },
    "analyzer": {
      "id": "gcs",
      "name": "GitLab Container Scanning",
      "vendor": {
        "name": "GitLab"
      }
    },
    "type": "container_scanning",
    "start_time": "",
    "end_time": "",
    "status": "success"
  }
}
