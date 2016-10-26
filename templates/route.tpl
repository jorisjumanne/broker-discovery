apiVersion: v1
items:
{{range .items}}{{if eq .status.phase "Running" }}- apiVersion: v1
  kind: Route
  metadata:
    name: {{ .metadata.name }}
    labels:
      broker-discovery: "yes"
  spec:
    host: {{ .metadata.name }}-{{ .metadata.namespace }}.apps.ota.ose.rabobank.nl
    tls:
      termination: passthrough
    to:
      kind: Service
      name: {{ .metadata.name }}
- apiVersion: v1
  kind: Service
  metadata:
    name: {{ .metadata.name }}
  spec:
    ports:
    - port: 9093
      protocol: TCP
      targetPort: 9093
    sessionAffinity: None
    type: ClusterIP
- apiVersion: v1
  kind: Endpoints
  metadata:
    name: {{ .metadata.name }} 
  subsets:
  - addresses:
    - ip: {{ .status.podIP }}
    ports:
    - name: http
      port: 9093
      protocol: TCP{{end}}{{end}}
kind: List
metadata: {}
