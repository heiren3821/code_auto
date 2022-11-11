# code_auto
This is a project based on freemarker template that can automatically generate all codes. Based on the given configuration file, it can automatically generate relevant module codes, including basic modules, api interface modules, and management background (commonly used add, delete, modify, and query functions)

# How To Do
1. Edit template location - src/main/java/com/code/gen/def
Basic fields have basic rules. The details are as follows:

 1.Project Definition    projectName,packagePrefix,projectDesc
 2.Class Global Definition  packageSuffix,BeanName,tableName,menuName,tableComment
 3.Field Definition fieldName,columnName,dataType,columnType,comment,maxLength.

The default sample template can be viewed in BeanInfo.txt under the template directory
2. After editing the template information, run the MainProcessor program

'''
 public static void main(String[] args) {
       //TODO pls note change template name if use new one.
	Config.setDefFileName("BeanInfo.txt");
 ProjectProcessor.handle();
 }
'''

3. After running, the sample code is under the output folder
It is a file that can be run directly.

NOTE: In order to unify, more default versions of jar packages are used
4. In addition to the current code auto generation example
Based on freemarker's template capability and java's combination capability, you can do many changes. You can automatically generate changes as long as you adjust certain configurations

Contributing
I welcome any and all contributions. Just create a PR or an issue. To contribute code.
