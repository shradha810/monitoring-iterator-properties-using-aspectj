
import java.util.*;
import org.aspectj.lang.*;

@SuppressWarnings("unchecked")
public aspect aspectj {
	Map<Iterator,Collection> iterToColl = new IdentityHashMap<Iterator,Collection>();
	Integer flag=0, flag1=0;

	/*create*/
	after(Collection c) returning (Iterator i):
		call(* Collection.iterator()) && target(c) {
		iterToColl.put(i,c);
	}
	
	/*add*/
	after(Collection c) returning:
		call(* Collection.add(..)) && target(c) && !within(aspectj) {
		iterToColl.values().remove(c);
	}
	
	/*remove*/
	after(Collection c) returning:
		call(* Collection.remove(..)) && target(c) && !within(aspectj){
			flag1=1;
			iterToColl.values().remove(c);
	}
	
	/*iter*/
	before(Iterator i):
		call(* Iterator.*()) && target(i) {
		if(!iterToColl.containsKey(i))
		{
			if(flag1==1)
			{
				System.out.println("Removing an item from collection");
			}
			System.out.println("FailSafeIter: iterating over updated collection");
			throw new ConcurrentModificationException();	
		}
	}
	
	before(Iterator i):
		call(* Iterator.hasNext()) && target(i){
	    flag = 0;
	}
	    
	before(Iterator i):
		call(* Iterator.next()) && target(i){
		if(flag == 1)
		{
			System.out.println("Iterating over a collection: two consecutive next calls");
			throw new ConcurrentModificationException();
		}
		else
		{
			flag=1;
		}
	}
}
