wget https://aka.ms/downloadazcopy-v10-linux
tar -xzf downloadazcopy-v10-linux
chmod +x azcopy_linux_amd64_*/azcopy
sudo mv azcopy_linux_amd64_*/azcopy /usr/bin

rm -rf azcopy_linux_amd64_*  downloadazcopy-v10-linux
