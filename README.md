hurdle 

creating key pair 

first  i think i need two keypair for both controlplane and worker node 

error happen , so i try to use only one keypair for both , 

error happen again 

supposely i should put my public key in the code , but i think thats not a good practice , i change using file("~/.ssh/ed25519.pub) but error keep getting the error 

since i use hcp i need i to add my public key in hcp secret which can be stored in hcp for terraform variable . terraform cant fetch directly in my local system since i use hcp. 

│ Error: Invalid function argument
│ 
│   on main.tf line 82, in resource "aws_key_pair" "deployer":
│   82:   public_key = file("~/.ssh")
│     ├────────────────
│     │ while calling file(path)
│ 
│ Invalid value for "path" parameter: no file exists at "~/.ssh"; this
│ function works only with files that are distributed as part of the
│ configuration source code, so if this file will be created by a resource in
│ this configuration you must instead obtain this result from an attribute of
│ that resource.
╵
Operation failed: failed running terraform plan (exit 1)