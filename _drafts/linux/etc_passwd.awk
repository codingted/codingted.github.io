BEGIN{
FS=":";
print "Name\tUserId\tGroupId\tHomeDir";
}
{
    print $1"\t"$2"\t"$3"\t"$6;
}
END{
    print NR, ",Records processed";
}

