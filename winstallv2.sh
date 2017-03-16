#/usr/
#Bash Ubuntu on Windows 10: Install Package 1 (winstall_v2.sh)

# User must apphend /etc/hosts with /etc/hostname as here:
#cat /etc/hostname 
# Then replace $hostname with result of previous command:
#echo "127.0.0.1 $hostname" >> /etc/hosts

# User must link windows desktop to linux shell:
#ln -s '/mnt/c/Users/#USERNAME#/Desktop' ~/desktop
#mkdir '/mnt/c/Users/#USERNAME#/Desktop/unix'
#ln -s '/mnt/c/Users/#USERNAME#/Desktop/unix' ~/unix

#Exit upon pipefail
set -uef -o pipefail
# Update linux and basic set-up.
cd ~
# Initial Linux Update and basic package installation.
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y curl unzip build-essential ncurses-dev
sudo apt-get install -y byacc zlib1g-dev python-dev git cmake
sudo apt-get install -y python-pip libhtml-parser-perl libwww-perl
sudo apt-get install -y default-jdk ant
sudo apt-get install -y ack-grep
sudo apt-get install -y dos2unix
# Download a minimal profile
curl http://data.biostarhandbook.com/install/bashrc.txt >> ~/.bashrc
echo "set background=dark" >> .vimrc
curl http://data.biostarhandbook.com/install/bash_profile.txt >> ~/.bashprofile
# Make bin and curl tools.
mkdir -p ~/unix/bin
mkdir -p ~/unix/src
mkdir -p ~/unix/ncbi/public/sra
cd ~/unix/bin
cd ~/unix/bin
curl http://data.biostarhandbook.com/install/doctor.py > doctor.py
chmod +x ~/unix/bin/doctor.py
sed -i -e 's+~/bin+~/unix/bin+g' ~/unix/bin/doctor.py
curl http://data.biostarhandbook.com/scripts/wonderdump.sh > wonderdump
chmod +x ~/unix/bin/wonderdump
sed -i -e 's+~/ncbi+~/unix/ncbi+g' ~/unix/bin/wonderdump
printf "\n Basic Linux Setup and Tool Installations Complete\n Begin Miniconda Installation\n";
# Install miniconda to /root/unix/bin/miniconda3
cd ~/unix
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -bp /root/unix/bin/miniconda3
printf "\n Miniconda Installation Successful\n Updating Bash Profile\n";
cat <<EOT >> ~/.bashrc

# Winstall Bash Profile Update 1:

#Fix dark illegible blue file extensions on Windows.
LS_COLORS='rs=0:di=1;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';" ~/.bashrc
export LS_COLORS

# Update path to include windows bin and miniconda.
export PATH=~/unix/bin:$PATH
export PATH=~/unix/bin/miniconda3:$PATH
export PATH=~/unix/bin/miniconda3/bin:$PATH

EOT
printf "\n Bash Profile Update Part 1 Complete\n";
echo 'source ~/.bashrc'
printf "\n Install Miniconda Channels\n";

#test conda installation by typing conda list
# Genome Analysis Toolkit
conda install gatk -y
# Requires gatk registration, download installer and move to ~/unix/ prior to executing script.
gatk_file="GenomeAnalysisTK-3.7.tar.bz2"
cp ~/unix/$gatk_file ~/unix/bin/miniconda3/bin
gatk-register ~/unix/bin/miniconda3/bin/$gatk_file --noversioncheck
# Bowtie2 installation.
cd ~/unix/src
curl -OL http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.1/bowtie2-2.3.1-linux-x86_64.zip
unzip bowtie2-2.3.1-linux-x86_64.zip 
# Bowtie Installation.
cd ~/unix/src
curl -OL https://sourceforge.net/projects/bowtie-bio/files/bowtie/1.2.0/bowtie-1.2-linux-x86_64.zip
unzip bowtie-1.2-linux-x86_64.zip
#export in winstall bashrc update 2
# Entrez-Direct
cd ~/unix/src
curl ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/edirect.zip > ~/unix/src/edirect.zip
unzip -o ~/unix/src/edirect.zip -d ~/unix/src
#export in winstall bashrc update 2
# remember to source.
# Hisat2 from binaries.
cd ~/unix/src
# Variable for future modification.
hisat2_web="ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.0.5-Linux_x86_64.zip"
curl -OL $hisat2_web
unzip hisat2-2.0.5-Linux_x86_64.zip
ln -s ~/unix/src/hisat2-2.0.5/hisat2-build ~/unix/bin
ln -s ~/unix/src/hisat2-2.0.5/hisat2 ~/unix/bin
#export in winstall bashrc update 2
# Install tophat from source.
set -u -e -f -o pipefail
cd ~/unix/src 
curl -kO https://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.0.Linux_x86_64.tar.gz 
tar xzvf tophat-2.1.0.Linux_x86_64.tar.gz
#export in winstall bashrc update 2
#Winstall bashrc update 2:
cat <<EOT >> ~/.bashrc

# Winstall bashrc update 2:

# Bowtie directory to path.
export PATH=~/unix/src/bowtie2-2.3.1:$PATH
export PATH=~/unix/src/bowtie-1.2:$PATH

# Entrez-Direct to path.
export PATH=~/unix/src/edirect:$PATH

#Tophat to path.
export PATH=~/unix/src/tophat-2.1.0.Linux_x86_64:$PATH

EOT
printf "bashrc_update_2_complete\n";
echo 'source ~/.bashrc'
# perl-lwp-protocol-https fails to extract
# conda install perl-lwp-protocol-https -y 
printf "Installation Complete\n trying cutadapt.\n";
# Cutadapt may have issue with github.
cd ~/unix/src
git clone git@github.com:marcelm/cutadapt.git 
cd cutadapt 
python setup.py install --user 
# Link to bin 
ln -s ~/Library/Python/2.7/bin/cutadapt ~/unix/bin/
printf "Cutadapt Install Complete.\n";