
# shell-script

## Adicionar no seu .zshrc para autoload no terminal

    for file in $(find ~/shell-script -type f -name "*.sh"); do
      script_name=$(basename "$file" .sh)
      alias $script_name="$file"
    done
