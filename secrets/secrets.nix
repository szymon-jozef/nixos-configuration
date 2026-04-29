let
  szymon_pitagoras = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHVimjs9wyiBBa0A9UlyhXdQKhI/MrR8CJUudtb28zPf";
  szymon_paderewski = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDuD2CO1T4XESxSJ8Cx0aJMUpA8nkZzT83PuzJpW7qr7";
  szymon_dmowski = "";

  users = [
    szymon_pitagoras
    szymon_dmowski
    szymon_paderewski
  ];

  pitagoras = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJdKis81AKMs1Ks457WJVLbzo/WgregoG8wGjnXAJrw+";
  paderewski = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIeNmEY42ddkvkuGjEIfxjNvXVhMi29dRhDR0xX6o+6t";
  dmowski = "";
  systems = [
    pitagoras
    dmowski
    paderewski
  ];
in
{
  "wifi.age".publicKeys = users ++ systems;
}
