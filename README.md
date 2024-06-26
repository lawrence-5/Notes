# powershell
powershell

.net framework的垃圾回收机制
Retain VM如果设置为true，就是说回收来空间暂时不交还给OS，这样可能没办法被其他应用所利用，并且在资源监视器中，还显示为应用使用的内存。
其实该应用可以用他们来存储新的数据，只是不显示为可用内存。
在占用大量的内存的应用中，最好设置为交还给OS。

https://learn.microsoft.com/en-us/dotnet/core/runtime-config/garbage-collector#retain-vm
