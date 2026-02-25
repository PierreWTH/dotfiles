"use strict";var p=Object.defineProperty;var W=Object.getOwnPropertyDescriptor;var C=Object.getOwnPropertyNames;var _=Object.prototype.hasOwnProperty;var P=(t,i)=>{for(var n in i)p(t,n,{get:i[n],enumerable:!0})},E=(t,i,n,s)=>{if(i&&typeof i=="object"||typeof i=="function")for(let c of C(i))!_.call(t,c)&&c!==n&&p(t,c,{get:()=>i[c],enumerable:!(s=W(i,c))||s.enumerable});return t};var F=t=>E(p({},"__esModule",{value:!0}),t);var M={};P(M,{default:()=>A});module.exports=F(M);var e=require("@raycast/api"),l=require("react");var f=require("child_process"),u=require("fs"),h=require("@raycast/api"),O="/Applications/kitty.app/Contents/MacOS/kitten",L=5e3;function R(){try{return(0,u.readdirSync)("/tmp").filter(t=>t.startsWith("kitty-socket-")).map(t=>`/tmp/${t}`).find(t=>(0,u.statSync)(t).isSocket())}catch{return}}function g(){let{socketPath:t}=(0,h.getPreferenceValues)();return t||R()||"/tmp/kitty-socket"}function m(t){let i=g(),n=`${O} @ --to unix:${i} ${t.join(" ")}`;return(0,f.execSync)(n,{encoding:"utf-8",timeout:L}).trim()}function w(){try{return(0,f.execSync)("pgrep -x kitty",{encoding:"utf-8",timeout:3e3}),!0}catch{return!1}}function b(){return(0,u.existsSync)(g())}function k(){(0,f.execSync)(`osascript -e 'tell application "kitty" to activate'`,{timeout:3e3})}function S(){let t=m(["ls"]);return JSON.parse(t)}function T(t){m(["focus-tab",`--match=id:${t}`])}function x(t){m(["close-tab",`--match=id:${t}`])}function K(t){if(!w())return"not_running";if(!b())return"no_socket";let i=t instanceof Error?t.message:String(t);return i.includes("ETIMEDOUT")||i.includes("timed out")?"timeout":i.includes("Permission denied")||i.includes("remote control")?"remote_disabled":"unknown"}var v=require("@raycast/api"),I=require("react/jsx-runtime"),D=`
# Kitty Remote Control Not Available

To use this extension, you need to enable Kitty's remote control via a Unix socket.

## Setup Instructions

Add the following lines to your Kitty configuration file (\`~/.config/kitty/kitty.conf\`):

\`\`\`
allow_remote_control socket-only
listen_on unix:/tmp/kitty-socket-{kitty_pid}
\`\`\`

Then **restart Kitty** for the changes to take effect.

## Verify

After restarting, check that the socket exists:

\`\`\`bash
ls -la /tmp/kitty-socket-*
\`\`\`

And test remote control:

\`\`\`bash
kitten @ --to unix:/tmp/kitty-socket-$(pgrep -x kitty) ls
\`\`\`

## Custom Socket Path

The extension auto-detects sockets matching \`/tmp/kitty-socket-*\`. If you use a different path, set it in the **Socket Path** preference.
`;function $(){return(0,I.jsx)(v.Detail,{markdown:D})}var r=require("react/jsx-runtime");function N(t){let i=[];for(let n of t)for(let s of n.tabs){let c=s.windows.find(d=>d.is_focused)||s.windows[0];i.push({osWindowId:n.id,tab:s,cwd:c?.cwd||"",windowCount:s.windows.length,isFocused:n.is_focused&&s.is_focused})}return i}function A(){let[t,i]=(0,l.useState)([]),[n,s]=(0,l.useState)(!0),[c,d]=(0,l.useState)(!1),y=async()=>{s(!0);try{if(!w()){i([]),s(!1),await(0,e.showToast)({style:e.Toast.Style.Failure,title:"Kitty is not running"});return}if(!b()){d(!0),s(!1);return}let o=S();i(N(o))}catch(o){let a=K(o);a==="no_socket"||a==="remote_disabled"?d(!0):await(0,e.showToast)({style:e.Toast.Style.Failure,title:"Failed to list tabs",message:String(o)})}finally{s(!1)}};return(0,l.useEffect)(()=>{y()},[]),c?(0,r.jsx)($,{}):(0,r.jsx)(e.List,{isLoading:n,searchBarPlaceholder:"Search Kitty tabs...",children:t.length===0&&!n?(0,r.jsx)(e.List.EmptyView,{title:"No tabs found",description:"Open a Kitty window first"}):t.map(o=>(0,r.jsx)(e.List.Item,{title:o.tab.title,subtitle:o.cwd,accessories:[...o.windowCount>1?[{text:`${o.windowCount} panes`}]:[],...o.isFocused?[{icon:e.Icon.Eye,tooltip:"Focused"}]:[],{text:`Window ${o.osWindowId}`}],actions:(0,r.jsxs)(e.ActionPanel,{children:[(0,r.jsx)(e.Action,{title:"Focus Tab",icon:e.Icon.Window,onAction:async()=>{try{T(o.tab.id),k()}catch(a){await(0,e.showToast)({style:e.Toast.Style.Failure,title:"Failed to focus tab",message:String(a)})}}}),(0,r.jsx)(e.Action.CopyToClipboard,{title:"Copy Tab Title",content:o.tab.title,shortcut:{modifiers:["cmd"],key:"t"}}),(0,r.jsx)(e.Action,{title:"Copy Working Directory",icon:e.Icon.Clipboard,shortcut:{modifiers:["cmd","shift"],key:"c"},onAction:async()=>{await e.Clipboard.copy(o.cwd),await(0,e.showToast)({style:e.Toast.Style.Success,title:"Copied",message:o.cwd})}}),(0,r.jsx)(e.Action,{title:"Close Tab",icon:e.Icon.Trash,style:e.Action.Style.Destructive,shortcut:{modifiers:["cmd","shift"],key:"backspace"},onAction:async()=>{try{x(o.tab.id),await y()}catch(a){await(0,e.showToast)({style:e.Toast.Style.Failure,title:"Failed to close tab",message:String(a)})}}}),(0,r.jsx)(e.Action,{title:"Refresh",icon:e.Icon.ArrowClockwise,shortcut:{modifiers:["cmd"],key:"r"},onAction:y})]})},`${o.osWindowId}-${o.tab.id}`))})}
