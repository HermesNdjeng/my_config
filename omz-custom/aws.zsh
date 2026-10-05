# AWS: switch profile and log in via SSO only if the session expired
awsp() {
  local profile="$1"
  export AWS_PROFILE="$profile"
  if ! aws sts get-caller-identity >/dev/null 2>&1; then
    echo "Session expirée pour $profile, connexion…"
    aws sso login --profile "$profile"
  fi
  aws sts get-caller-identity --query Arn --output text
}
