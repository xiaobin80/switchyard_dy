# switchyard_dy
train wagon marshalling station - dy

- database initializer    
init
- database management program
supertools
- main program    
CDP_x23
- Servo program    
servoSystem201

# Dev
- IDE: Delphi6/7
- DB: MS SQL 2000

## [EhLib](https://blog.karatos.in/a?ID=00050-c09449dd-710f-4910-8306-f45241f7c635)

Delphi6/7: 由Delphi x替代
EhLib60, EhLib70: 由EhLib00替代

0. Copy Folder
Copy the common and DataService files in EhLib to the Delphi x directory    
删除其他版本(BCB5, BCB6, BDS2006.Vcl, BDS2006.VclNet, Delphi5, Delphi8.NotReady, Delphi9.Vcl, Delphi9.VclNet)的文件夹。

将整理处理的文件夹拷贝到:
```
C:\Program Files\Delphi x\Lib\EhLib_4.1.4\Delphi6
```
or
```
C:\Program Files\Delphi x\Lib\EhLib_4.1.4\Delphi7
```

1. Add Path    
Add the EHLIB path in TOOLS->Environment Options->Library->Library Path.

2. Instatll    
在Delphi x中打开:    

- EhLib00.dpk    
```
Compile(但不要安装)。
```

- DclEhLib00.dpk     
```
Compile -> Install
```
An EhLib component page appears in the component panel.

3. Test    
Open the attached DEMOS, compile and run, test the installation is successful.
```
DEMOS\DEMOO1\Project1.dpr
```
