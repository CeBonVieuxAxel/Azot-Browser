const { contextBridge, ipcRenderer } = require('electron');
const invoke = (channel, ...args) => ipcRenderer.invoke(channel, ...args);
contextBridge.exposeInMainWorld('azot', {
  windowControls: { minimize: () => ipcRenderer.send('window:minimize'), maximize: () => ipcRenderer.send('window:maximize'), close: () => ipcRenderer.send('window:close') },
  tabs: { create: url => invoke('tabs:create', url), close: id => invoke('tabs:close', id), select: id => invoke('tabs:select', id), move: (from, to) => invoke('tabs:move', from, to), duplicate: id => invoke('tabs:duplicate', id), reopen: () => invoke('tabs:reopen'), onState: callback => ipcRenderer.on('tabs:state', (_, state) => callback(state)) },
  navigate: (action, value) => invoke('navigate', action, value), shieldToggle: domain => invoke('shield:toggle', domain),
  layout: { sidebar: width => invoke('layout:sidebar', width) },
  overlay: { set: open => invoke('overlay:set', open) },
  themes: { get: () => invoke('themes:get'), save: themes => invoke('themes:save', themes) },
  history: { get: () => invoke('history:get'), delete: id => invoke('history:delete', id), clear: () => invoke('history:clear') },
  settings: { get: () => invoke('settings:get'), save: settings => invoke('settings:save', settings), clearData: () => invoke('data:clear') },
  extensions: { get: () => invoke('extensions:get'), add: () => invoke('extensions:add'), toggle: id => invoke('extensions:toggle', id), remove: id => invoke('extensions:remove', id) }
});
