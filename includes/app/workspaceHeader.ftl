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
<script type="text/javascript">
    var showProjectTree = <#if 'Y' == projectPreferences.SHOW_PROJECT_TREE?default('Y')>true<#else>false</#if>;
    var showTasktList = <#if 'Y' == projectPreferences.SHOW_TASK_LIST?default('Y')>true<#else>false</#if>;
    var showEditor = <#if 'Y' == projectPreferences.SHOW_EDITOR?default('Y')>true<#else>false</#if>;
    var lastSprintId = "${projectPreferences.LAST_SPRINT?default('')}";
    var lastStoryId = "${projectPreferences.LAST_STORY?default('')}";
    var findStories = "<@ofbizUrl>findStories</@ofbizUrl>";
    var loadTree = "<@ofbizUrl>loadTree</@ofbizUrl>";
    var loadStory = "<@ofbizUrl>loadStory</@ofbizUrl>";   
    var loadSprint = "<@ofbizUrl>loadSprint</@ofbizUrl>";
    var createStory = "<@ofbizUrl>createStory</@ofbizUrl>";
    var updateStory = "<@ofbizUrl>updateStory</@ofbizUrl>";
    var createSprint = "<@ofbizUrl>createSprint</@ofbizUrl>";                        
    var updateSprint = "<@ofbizUrl>updateSprint</@ofbizUrl>";      
    var loadComments = "<@ofbizUrl>loadComments</@ofbizUrl>";
    var createComment = "<@ofbizUrl>createComment</@ofbizUrl>";
    var currentProjectId = "${currentProjectId}";
    var currentProjectName = "${currentProject.workEffortName}";
    var currentPartyId = 'DEFAULT_USER';
    var backlogId = '${backlogId?default("")}';
        
//project party data      
var projectPartyData = 
<#if projectParties?exists && projectParties?has_content>
[<#list projectParties as workEffortAndPartyAssign>
<#assign person = workEffortAndPartyAssign.getRelatedOneCache("Person")?if_exists>
{id: '${workEffortAndPartyAssign.partyId?default("")}', name: '${person.firstName?default("NA")} ${person.lastName?default("NA")}'}<#if workEffortAndPartyAssign_has_next>, </#if>
</#list>];
<#else>
[];
</#if>

var projectPartyStore = Ext.create('Ext.data.Store', {
    model: 'GenericIdName',
    data: projectPartyData
});

//status data
var statusData = 
<#if statusItems?exists && statusItems?has_content>
[<#list statusItems as statusItem>
{id: '${statusItem.statusId?default("")}', name: '${statusItem.description?default("NA")}'}<#if statusItem_has_next>, </#if>
</#list>];
<#else>
[];
</#if>

var storyStatusStore = Ext.create('Ext.data.Store', {
    model: 'GenericIdName',
    storeId: 'storyStatusStore',
    data: statusData
});

//story type data
var storyTypeData = 
<#if workEffortPurposeTypes?exists && workEffortPurposeTypes?has_content>
[<#list workEffortPurposeTypes as workEffortPurposeType>
{id: '${workEffortPurposeType.workEffortPurposeTypeId?default("")}', name: '${workEffortPurposeType.description?default("NA")}'}<#if workEffortPurposeType_has_next>, </#if>
</#list>];
<#else>
[];
</#if>

var storyTypeStore = Ext.create('Ext.data.Store', {
    model: 'GenericIdName',
    data: storyTypeData
});

<#-- sprints
var sprintData = 
<#if sprints?exists && sprints?has_content>
[<#list sprints as sprint>
{id: '${sprint.workEffortId?default("")}', name: '${sprint.workEffortName?default("NA")}'}<#if sprint_has_next>, </#if>
</#list>];
<#else>
[];
</#if>console.log(sprintData)  -->
var sprintStore = Ext.create('Ext.data.Store', {
    model: 'GenericIdName'
    //,data: sprintData
});

//related comps
var relatedComponentData = 
<#if relatedComponents?exists && relatedComponents?has_content>
[<#list relatedComponents as relatedComponent>
{id: '${relatedComponent.enumId?default("")}', name: '${relatedComponent.description?default("NA")}'}<#if relatedComponent_has_next>, </#if>
</#list>];
<#else>
[];
</#if>

var relatedComponentStore = Ext.create('Ext.data.Store', {
    model: 'GenericIdName',
    data: relatedComponentData
});

//priority
<#assign priorities = ["1 - High", "2 - Medium", "3 - Low"]>
var priorityData = 
<#if priorities?exists && priorities?has_content>
[<#list priorities as priority>
{id: '${priority_index + 1}', name: '${priority}'}<#if priority_has_next>, </#if>
</#list>];
<#else>
[];
</#if>

var priorityStore = Ext.create('Ext.data.Store', {
    model: 'GenericIdName',
    data: priorityData
});
</script>
<script type="text/javascript" src="<@ofbizContentUrl>/app/model/WorkspaceModels.js</@ofbizContentUrl>"></script>
<script type="text/javascript" src="<@ofbizContentUrl>/app/view/ProjectTree.js</@ofbizContentUrl>"></script>
<script type="text/javascript" src="<@ofbizContentUrl>/app/view/EditorInfo.js</@ofbizContentUrl>"></script>
<script type="text/javascript" src="<@ofbizContentUrl>/app/view/SprintForm.js</@ofbizContentUrl>"></script>    
<script type="text/javascript" src="<@ofbizContentUrl>/app/view/StoryForm.js</@ofbizContentUrl>"></script>
<script type="text/javascript" src="<@ofbizContentUrl>/app/view/SprintGrid.js</@ofbizContentUrl>"></script>
<script type="text/javascript" src="<@ofbizContentUrl>/app/view/FilterMenu.js</@ofbizContentUrl>"></script>
<script type="text/javascript" src="<@ofbizContentUrl>/app/view/SprintInfo.js</@ofbizContentUrl>"></script>
<script type="text/javascript" src="<@ofbizContentUrl>/app/view/StoryContainer.js</@ofbizContentUrl>"></script>
<script type="text/javascript" src="<@ofbizContentUrl>/app/view/CommentInfo.js</@ofbizContentUrl>"></script>
<script type="text/javascript" src="<@ofbizContentUrl>/app/view/CommentForm.js</@ofbizContentUrl>"></script>
<script type="text/javascript" src="<@ofbizContentUrl>/app/view/CommentGrid.js</@ofbizContentUrl>"></script>
<script type="text/javascript" src="<@ofbizContentUrl>/app/view/ProjectInfo.js</@ofbizContentUrl>"></script>
<script type="text/javascript" src="<@ofbizContentUrl>/app/view/Workspace.js</@ofbizContentUrl>"></script>
<script type="text/javascript">
    Ext.Loader.setConfig({enabled: true});
    Ext.Loader.setPath('Ext.ux', '<@ofbizContentUrl>/ext-4.0.0/examples/ux/</@ofbizContentUrl>');
    Ext.Loader.setPath('Ext.ux.statusbar', '<@ofbizContentUrl>/ext-4.0.0/examples/ux/statusbar</@ofbizContentUrl>');    
    Ext.Loader.setPath('Ext.ux.layout', '<@ofbizContentUrl>/ext-4.0.0/examples/ux/layout</@ofbizContentUrl>');    
    Ext.require([
        'Ext.grid.*',
        'Ext.tree.*',
        'Ext.data.*',
        'Ext.toolbar.*',
        'Ext.util.*',
        'Ext.Action',
        'Ext.tab.*',
        'Ext.button.*',
        'Ext.form.*',
        'Ext.layout.container.Card',
        'Ext.layout.container.Border',
        'Ext.ux.PreviewPlugin', 
        'Ext.ux.statusbar.StatusBar',
        'Ext.ux.layout.Center'  
    ]);
    Ext.onReady(function(){
        Ext.QuickTips.init();
        var app = new TodoBrowser.Workspace();
    });
</script>