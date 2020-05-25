
-- Rename to  authn_providers_t  ?
-- Add  authn_type  OIDC / TwitterOAuth1 / FacebookOAuth2 / ...
--             no, instead:  OIDC / OAuth1 / OAuth2,  + alias = twitter / facebook / etc
--                                               + displ name = Twitter / Facebook ...
--
-- Then, later on (not now!), multi-site users can config their own FB app for example.
--
create table oidc_providers_t(
  site_id_c int not null,
  id_c int not null,
  authn_type_c,
  alias_c varchar not null,   -- —>   /-/auth/oidc/op_alias  +  /-/auth/oidc/op_alias/callback?code=....
  display_name_c varchar,
  enabled_c bool not null,
  trust_email_if_verified_c bool not null,
  link_account_no_login_c bool not null,
  gui_order_c int,
  sync_mode_c int not null,  -- ImportOnFirstLogin  or  SyncOnAllLogins
  op_authorization_url_c varchar not null,  -- rename to  oauth2_auth_url ?
  op_access_token_url_c varchar not null,  -- rename to  oauth2_token_url ?
  op_user_info_url_c varchar not null,  -- rename to  oauth2_profile_url ?
  op_logout_url_c varchar,
  op_client_id_c varchar not null,   -- oauth2_...  ?
  op_client_secret_c varchar not null,   -- oauth2_...  ?
  op_issuer_c varchar,   -- oidc_issuer_c  ?
  op_scopes_c varchar,   -- provider_scopes_c   no  ip_scopes_c ?  identity provider
  op_hosted_domain_c varchar,      -- e.g. Google Gsuite hosted domains
  op_send_user_ip bool,         -- so Google throttles based on the browser's ip instead

  constraint oidcproviders_p_id primary key (site_id_c, id_c),

  constraint oidcproviders_r_sites foreign key (site_id_c) references sites3 (id) deferrable,

  constraint oidcproviders_c_id_gtz check (id_c > 0),
  constraint oidcproviders_c_syncmode check (sync_mode_c between 1 and 10),
  constraint oidcproviders_c_alias_len check (length(alias_c) between 1 and 50),
  constraint oidcproviders_c_displayname_len check (length(display_name_c) between 1 and 200),
  constraint oidcproviders_c_opauthorizationurl_len check (length(op_authorization_url_c) between 1 and 200),
  constraint oidcproviders_c_opaccesstokenurl_len check (length(op_access_token_url_c) between 1 and 200),
  constraint oidcproviders_c_opuserinfourl_len check (length(op_user_info_url_c) between 1 and 200),
  constraint oidcproviders_c_oplogouturl_len check (length(op_logout_url_c) between 1 and 200),
  constraint oidcproviders_c_opclientid_len check (length(op_client_id_c) between 1 and 200),
  constraint oidcproviders_c_opclientsecret_len check (length(op_client_secret_c) between 1 and 200),
  constraint oidcproviders_c_opissuer_len check (length(op_issuer_c) between 1 and 200),
  constraint oidcproviders_c_opscopes_len check (length(op_scopes_c) between 1 and 200),
  constraint oidcproviders_c_ophosteddomain_len check (length(op_hosted_domain_c) between 1 and 200),
);


drop table oidc_providers_t;
