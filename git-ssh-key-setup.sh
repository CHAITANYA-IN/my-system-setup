cd ~/.ssh
ssh-keygen -t ecdsa -b 521 -C $EMAIL
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_github_titan
xclip -selection clipboard ~/.ssh/id_github_titan.pub
ssh -T git@github.com
