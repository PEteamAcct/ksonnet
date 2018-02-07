local k = import 'k.libsonnet';
local service = k.core.v1.service.mixin;
local psg = import '../ldap.libsonnet';

k.core.v1.list.new([
  psg.parts.secrets('dev-alex', "ldap-app", "GOODPASSWORD"),
  psg.parts.service('dev-alex', "ldap-app", false),
])
