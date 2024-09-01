

set -e


if ! [ -x "$(command -v terraform)" ]; then
  echo 'Error: Terrafrom CLI not found' >&2
  exit 1
fi


echo "Checking terraform configs"
terraform validate

echo "Planning"
terraform plan -out=tfplan

echo "Applying"
terraform apply -auto-approve tfplan



echo "Infrastructure created success!"
rm tfplan

