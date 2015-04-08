# Find shorthand
function f() {
  find . -name "$1"
}


# Make new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

# Get gzipped file size
function gz() {
  echo "Original size (bytes): "
  cat "$1" | wc -c
  echo "Gzipped size (bytes): "
  gzip -c "$1" | wc -c
}

# Extract archives of various types
function extract() {
  if [ -f $1 ] ; then
    local dir_name=${1%.*}  # Filename without extension
    case $1 in
      *.tar.bz2)  tar xjf           $1 ;;
      *.tar.gz)   tar xzf           $1 ;;
      *.tar.xz)   tar Jxvf          $1 ;;
      *.tar)      tar xf            $1 ;;
      *.tbz2)     tar xjf           $1 ;;
      *.tgz)      tar xzf           $1 ;;
      *.bz2)      bunzip2           $1 ;;
      *.rar)      unrar x           $1 $2 ;;
      *.gz)       gunzip            $1 ;;
      *.zip)      unzip -d$dir_name $1 ;;
      *.Z)        uncompress        $1 ;;
      *)          echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Setup syncronization of current Git repo with GitHub repo of the same name
# USAGE: git-github [repo]
function git-github() {
  user="sapegin"
  repo=${1-`basename "$(pwd)"`}
  git remote add origin "git@github.com:$user/$repo.git"
  git push -u origin master
}

# Setup syncronization of current Git repo with Bitbucket repo of the same name
# USAGE: git-bitbucket [repo]
function git-bitbucket() {
  user="sapegin"
  repo=${1-`basename "$(pwd)"`}
  git remote add origin "git@bitbucket.org:$user/$repo.git"
  git push -u origin master
}

# Add remote upsteam
# USAGE: git-fork <original-author>
function git-fork() {
  user=$1
  if [[ "$user" == "" ]]
  then
    echo "Usage: git-fork <original-author>"
  else
    repo=`basename "$(pwd)"`
    git remote add upstream "https://github.com/$user/$repo.git"
  fi
}

# Sync branch with upstream
# USAGE: git-upstream [branch]
function git-upstream() {
  branch=${1-master}
  git fetch upstream
  git co origin $branch
  git merge upstream/$branch
}

# Print nyan cat
# https://github.com/steckel/Git-Nyan-Graph/blob/master/nyan.sh
function nyan() {
  e='\033'
  RESET="$e[0m"
  BOLD="$e[1m"
  CYAN="$e[0;96m"
  RED="$e[0;91m"
  YELLOW="$e[0;93m"
  GREEN="$e[0;92m"

  echo
  echo -en $RED'-_-_-_-_-_-_-_'
  echo -e $RESET$BOLD',------,'$RESET
  echo -en $YELLOW'_-_-_-_-_-_-_-'
  echo -e $RESET$BOLD'|   /\_/\\'$RESET
  echo -en $GREEN'-_-_-_-_-_-_-'
  echo -e $RESET$BOLD'~|__( ^ .^)'$RESET
  echo -en $CYAN'-_-_-_-_-_-_-_-'
  echo -e $RESET$BOLD'""  ""'$RESET
}