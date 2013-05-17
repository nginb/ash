-- @author Simon Symeonidis 
-- @date   Thu May 16 2013
package body Request_Helpers is 
  -- Parse the request type (get first line, see what type of http method it
  -- is and return the valid enumaration).
  function Parse_Request_Type(R : String)
  return Request_Type is 
    package tmp renames Ada.Text_IO;
    First, Last : Positive;
    Found       : Boolean;
  begin
    Get_Word(R, First, Last, Found);

    if    R(First..Last) = "GET"    then
      tmp.put_line("Get request");
      return GET;
    elsif R(First..Last) = "POST"   then 
      tmp.put_line("post request");
      return POST;
    elsif R(First..Last) = "PUT"    then
      tmp.put_line("put request");
      return PUT;
    elsif R(First..Last) = "HEAD"   then 
      tmp.put_line("head request");
      return HEAD;
    elsif R(First..Last) = "DELETE" then
      tmp.put_line("delete request");
      return DELETE;
    else
      return GET;
    end if;
  end Parse_Request_Type;

  -- This extracts the path requested from the first line in the http method
  -- eg:
  --
  --   GET /index.html
  --   ...
  -- 
  -- Would return a string with "index.html"
  -- @note Thanks to
  --   http://rosettacode.org/wiki/Regular_expressions#Ada
  function Parse_Request_URI(R : String)
  return String is 
    First, Last : Positive;
    Found : Boolean;
    -- Breaking everything down to words will work fine. 
  begin 
    Get_Word(R, First, Last, Found);
    Get_Word(R(Last+1..R'Last), First, Last, Found);

    if Found then
    return R(First..Last);
    end if;
    return "uri not found.";
  end Parse_Request_URI;

  procedure Get_Word(S           : String; 
                     First, Last : out Positive; 
		     Found       : out Boolean) is
    Pattern     : constant String := "(\S+)"; 
    Compiled    : GNAT.Regpat.Pattern_Matcher :=
      GNAT.Regpat.Compile(Pattern);
    Match_Array : GNAT.Regpat.Match_Array(0..1);
  begin
    GNAT.Regpat.Match(Compiled, S, Match_Array);
    Found := not GNAT.Regpat."="(Match_Array(1), GNAT.Regpat.No_Match);

    if Found then
      First := Match_Array(1).First;
      Last  := Match_Array(1).Last;
    end if;
  end Get_Word;
end Request_Helpers; 

