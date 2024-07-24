{...}: 
{

  services.borgbackup = {
    # it said shit runs better when borg is installed on the remote host too? whatever.
    enable = true;

  };

}