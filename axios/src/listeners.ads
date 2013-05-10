-- @author Simon Symeonidis
-- @date   
--
-- This is the listener for http connections to port 80. 
-- This should delegate the request to some handler, and 
-- execute the proper logic.
with 
  Ada.Text_IO,
  Ada.Strings.Unbounded,
  GNAT.Sockets,
  Ada.Exceptions; 

use 
  Ada.Exceptions,
  GNAT.Sockets; 

package Listeners is 

  -- This is basically the specification for web servers. The way this is done 
  -- allows us to create multiple listeners on the same machine.
  type Listener is tagged record
    Port_Number  : Integer range 0 .. 16#ffff#; 
    Host_Name    : Ada.Strings.Unbounded.Unbounded_String;
    Shutdown     : Boolean := False;
    WS_Root_Path : Ada.Strings.Unbounded.Unbounded_String;
  end record;

  procedure Print_Info(This : Listener);
  procedure Listen(This : Listener);
  function Tiny_Name(This : Listener) return String;
  function Response_Date return String;
end Listeners;
