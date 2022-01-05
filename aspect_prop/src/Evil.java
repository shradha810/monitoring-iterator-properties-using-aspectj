import java.util.*;

public class Evil {
	public static void main(String[] args)
	{
		Collection<String> c = new ArrayList<String>();
		c.add("helloworld");
		c.add("Shradha");
		c.add("lalallalrfwrgvw");
		func(c);
		System.err.println(c);
	}
	
	private static void func(Collection<String> c)
	{
		//-----------Iterating over a collection.------------------
		for(Iterator<String> i = c.iterator();i.hasNext() ;)
		{
			String s = i.next();
			if(s.equals("Shradha"))
			{
				c.remove(s);
			}
		}
		
		//---------------Removing an item from collection-----------
//		for(Iterator<String> i = c.iterator(); ;)
//		{
//			String s = i.next();
//			if(s.equals("Shradha"))
//			{
//				c.remove(s);
//			}
//		}
		
		//--------------FailSafeIter---------------------
//		for(Iterator<String> i = c.iterator(); i.hasNext();)
//		{
//				c.add("Program Analysis");
//		}
		
	}
	
}
