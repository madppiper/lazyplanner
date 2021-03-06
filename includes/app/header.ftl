<#--
Copyright (C) Bilgin Ibryam http://www.ofbizian.com

This is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 2.1 of the License, or
(at your option) any later version.

Foobar is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this software.  If not, see http://www.fsf.org
-->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>  
    <title><#if workspace.workEffortName?exists>${workspace.workEffortName}<#else>Lazy Planner - Easy project planning</#if></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="description" content="Easy to use, Lazy Planner is the free online web-based project management and collaboration software. Projects, tasks, issues, bugs, resolved" />
    <link rel="shortcut icon" href="<@ofbizContentUrl>/app/images/lazy.ico</@ofbizContentUrl>"/>
    <link rel="stylesheet" href="<@ofbizContentUrl>/ext-4.0.0/resources/css/ext-all.css</@ofbizContentUrl>" type="text/css"/>
    <link rel="stylesheet" href="<@ofbizContentUrl>/app/images/custom.css</@ofbizContentUrl>" type="text/css"/>
    <script type="text/javascript" src="<@ofbizContentUrl>/ext-4.0.0/ext-all-debug.js</@ofbizContentUrl>"></script>  
    <script type="text/javascript" src="<@ofbizContentUrl>/app/model/functions.js</@ofbizContentUrl>"></script>
    <script type="text/javascript">
        var displayDateForm = "D d M Y";
        var logoutLabel = "${uiLabelMap.CommonLogout}";
        var userName = "${userLogin.userLoginId}";
        var logoutURL = "<@ofbizUrl>logout</@ofbizUrl>";
        var accountURL = "<@ofbizUrl>account</@ofbizUrl>";
        var workspaceURL = "<@ofbizUrl>workspace</@ofbizUrl>";
        var workspaceName = "<#if currentProject?exists>${currentProject.workEffortName?default('No Project Name')}<#else>${workspace.workEffortName?default('No Account Name')}</#if>";
        function createProjectMenu() {
          var menu =  Ext.create('Ext.menu.Menu', {});
          <#if projects?exists && projects?has_content>
            <#list projects as project>
                menu.add({
                    id : '${project.workEffortId}',
                    text: '${project.workEffortName?default("")}',
                    iconCls : 'bullet-green',
                     handler : function() {
                        gotoURL(workspaceURL + '?projectId=${project.workEffortId}');
                     }
                });
            </#list>;
          </#if>
            var projectButton =  Ext.create('Ext.Button', {
                text: 'Projects',
                iconCls: 'resources',
                menu : menu
            });
            return projectButton;
        }
        var projectMenu = createProjectMenu();
        var header =  Ext.create('Ext.toolbar.Toolbar', {
            region: 'north',
            border : '10 5 3 10',
            margins: '0 0 0 0',
            height: 30,
            cls: 'header-toolbar-panel',
            items : [
                       Ext.create('Ext.container.Container', {
                            //contentEl: 'north',
                            id : 'headerText',
                            html : workspaceName,
                            cls : 'north-title'
                       }),
                       {xtype: 'tbfill'},
                       <#if "WORKSPACE" == screenName>
                           //{xtype: 'tbseparator'},
                           { text: 'Account',
                           iconCls : 'wrench-orange',
                              handler : function() {
                                gotoURL(accountURL);
                              }
                           },
                       </#if>
                       {xtype: 'tbspacer'},
                       projectMenu
                       ,{xtype: 'tbspacer'}
                       ,{
                           //xtype:'splitbutton',
                           text : userName,
                           iconCls: 'user-green',
                           menu: [{
                                      text : logoutLabel,
                                      iconCls : 'lock-2',
                                      handler : function () {
                                          gotoURL(logoutURL);
                                      }
                                  }]
                       }
                       ,{xtype: 'tbspacer'}
                       ]
        });
        
        var footer = Ext.create('Ext.container.Container', {
            region: 'south',
            border : false,
            height: 20,
            contentEl: 'south',
            margins: '0 0 0 0',
            cls: 'footer-panel'
        });
    </script>   
     