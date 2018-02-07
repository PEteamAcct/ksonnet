// @apiVersion 0.0.1
// @name io.ksonnet.pkg.ldap-simple
// @description Deploy ldap backed by a persistent volume. ldap container is managed by
//   a deployment object and exposed to the network with a service. The
//   passwords are stored in a secret.
// @shortDescription A simple ldap deployment, backed by persistent storage.
// @param name string Name of app to attach as identifier to all components
// @param namespace string Namespace to specify destination in cluster; default is 'default'
// @param password string Password for the root/admin user.

local k = import 'k.libsonnet';
local psg = import 'incubator/ldap/ldap.libsonnet';

local appName = import 'param://name';
local namespace = import 'param://namespace';
local password = import 'param://password';

k.core.v1.list.new([
  psg.parts.secrets(namespace, appName, password),
  psg.parts.service(namespace, appName)
])
