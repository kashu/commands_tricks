function sword() 
{ 
    local word;
    word=$1;
    word=$(echo $word | tr ' ' '+');
    local prefix='https'
    local dotflg='.'
    local andflg='&'
    local qmflg='?'
    lynx -accept_all_cookies -source "$prefix://\
www${dotflg}bing${dotflg}com/\
dict/\
search${qmflg}q=$word${andflg}qs=n${andflg}form=CM${andflg}pq=$word${andflg}sc=0-0${andflg}sp=-1${andflg}sk=" | html2text | sed '1,12d' | less
}



function sword() 
{ 
    local word;
    word=$1;
    word=$(echo $word | tr ' ' '+');
    prefix='https'
    dotflg='.'
    andflg='&'
    qmflg='?'
    lynx -accept_all_cookies -source "$prefix://\
www${dotflg}bing${dotflg}com/\
dict/\
search${qmflg}q=$word${andflg}qs=n${andflg}form=CM${andflg}pq=$word${andflg}sc=0-0${andflg}sp=-1${andflg}sk=" | html2text | sed '1,12d' | ccze -A | less -R
}

