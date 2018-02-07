local k = import 'k.libsonnet';
local service = k.core.v1.service.mixin;

{
  parts:: {
    service(namespace, name, metricsEnabled=false, externalIpArray=null, selector={app:name})::
      local defaults= {
        type: 'ClusterIP',
        port: 389
      };

      {
        apiVersion: "v1",
        kind: "Service",
        metadata: {
          name: name,
          namespace: namespace,
          labels: {
            app: name,
          },
          [if metricsEnabled then "annotations"]: {
            "prometheus.io/scrape": "true",
            "prometheus.io/port": "9187"
          },
        },
        spec: {
          type: defaults.type,
          ports: [
            {
              name: "ldap",
              port: defaults.port,
              targetPort: "ldap",
            }
          ],
          [if externalIpArray != null then "externalIPs"]:
            externalIpArray,
          selector: selector
        },
      },


    secrets(namespace, name, ldapPassword, labels={app:name})::
      {
        apiVersion: "v1",
        kind: "Secret",
        metadata: {
          name: name,
          namespace: namespace,
          labels: labels,
        },
        type: "Opaque",
        data: {
          "ldap-password": std.base64(ldapPassword),
        },
      },

   
  }
}
