/*
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
 */
Ext.define('TodoBrowser.AccountEditor', {
	extend : 'Ext.panel.Panel',
	alias : 'widget.accountEditor',
	id : 'accountEditor',
	title : 'Account Settings',
	layout : 'card',
	activeItem : 0,
	//bodyStyle : 'padding:10px',
	initComponent : function() {
		this.accountHelp = this.wrapInPanel(Ext.create('widget.accountHelp', {}));
		this.workspaceForm = this.wrapInPanel(Ext.create('widget.workspaceForm', {trackResetOnLoad : true}));
		this.projectForm = this.wrapInPanel(Ext.create('widget.projectForm', {}));
		this.userForm = this.wrapInPanel(Ext.create('widget.userForm', {}));
		this.assignUserForm = this.wrapInPanel(Ext.create('widget.assignUserForm', {}));
		this.personForm = this.wrapInPanel(Ext.create('widget.personForm', {}));
		this.passwordForm = this.wrapInPanel(Ext.create('widget.passwordForm', {}));
		Ext.apply(this, {
			collapsible : false,
			floatable : false,
			split : true,
			dockedItems : [this.createToolbar()],
			bbar : this.createFooterBar(),
			items : [this.accountHelp, this.projectForm, this.workspaceForm, this.userForm, this.assignUserForm, this.personForm, this.passwordForm]
		});
		this.relayEvents(this.projectForm, ['projectCreate'])
		this.callParent(arguments);
	},
	
	wrapInPanel : function(item) {
		return Ext.create('Ext.Panel', {
			id : 'wapper_' + item.id,
			border : false,
			//bodyStyle : 'margin:10px',
			//layout:'ux.center',
			 layout: {
                 type:'vbox',
                 pack:'center',
                 align:'center'
             },
			items : item
		});	
	},
	
	createStart : function() {
		return Ext.create('Ext.Panel', {
			 title: 'Ajax Tab 2',
			 loader: {
	                 url: 'ajax2.htm',
	                 contentType: 'html',
	                 autoLoad: true,
	                 params: 'foo=123&bar=abc'
	         },
			id : 'startPanel',
			width: 600,
			border : true,
			//html : 'Account Manager Page'
		});
	},

	loadStart : function() {
		this.layout.setActiveItem('wapper_accountHelp');
	},

	newProject : function(title) {
		this.setTitle(title);
		this.layout.setActiveItem('wapper_projectForm');
		this.layout.getActiveItem().child('#projectForm').newProject();
	},

	loadProject : function(workEffortId, title) {
		this.setTitle(title);
		this.layout.setActiveItem('wapper_projectForm');
		this.layout.getActiveItem().child('#projectForm').loadProject(workEffortId);
	},
	
	loadAssignedProject : function(workEffortId, title) {
		this.setTitle( workEffortId + title);
		this.layout.setActiveItem('wapper_projectForm');
		this.layout.getActiveItem().child('#projectForm').loadProject(workEffortId);
		this.layout.getActiveItem().child('#projectForm').makeReadOnly();
	},

	loadUser : function(userId, title) {
		this.setTitle(title);
		this.layout.setActiveItem('wapper_userForm');
		this.layout.getActiveItem().child('#userForm').loadUser(userId);
	},

	loadPerson : function(title) {
		this.setTitle(title);
		this.layout.setActiveItem('wapper_personForm');
		this.layout.getActiveItem().child('#personForm').loadPerson();
	},

	loadWorkspace : function(title) {
		this.setTitle(title);
		this.layout.setActiveItem('wapper_workspaceForm');
		this.layout.getActiveItem().child('#workspaceForm').loadWorkspace();
	},

	loadPassword : function(title) {
		this.setTitle(title);
		this.layout.setActiveItem('wapper_passwordForm');
	},

	loadAssignUser : function(title) {
		this.setTitle(title);
		this.layout.setActiveItem('wapper_assignUserForm');
	},
	
	loadSettingsHelp : function(title) {
		this.setTitle(title);
		this.layout.setActiveItem('wapper_accountHelp');
		this.layout.getActiveItem().child('#accountHelp').loadSettings();
	},
	
	loadProjectsHelp : function(title) {
		this.setTitle(title);
		this.layout.setActiveItem('wapper_accountHelp');
		this.layout.getActiveItem().child('#accountHelp').loadAccount();
	},

	loadUsersHelp : function(title) {
		this.setTitle(title);
		this.layout.setActiveItem('wapper_accountHelp');
		this.layout.getActiveItem().child('#accountHelp').loadUsers();
	},

	loadAssignedProjectsHelp : function(title) {
		this.setTitle(title);
		this.layout.setActiveItem('wapper_accountHelp');
		this.layout.getActiveItem().child('#accountHelp').loadAssignedProjects();
	},
	
	createToolbar : function() {
		var items = [], config = {};
		items.push({
			scope : this,
			handler : this.createSrpint,
			text : 'Help',
			disabled : true,
			iconCls : 'help-2'
		});
		config.items = items;
		return Ext.create('widget.toolbar', config);
	},

	createFooterBar : function() {
		this.footerBar = Ext.create('Ext.ux.StatusBar', {
			id : 'editor-info-statusbar',
			text : 'Editor Info',
			iconCls : 'x-status-valid',
		})
		return this.footerBar;
	}
});