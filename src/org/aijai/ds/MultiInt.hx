package org.aijai.ds;

/**
 * Abstract class for storing up to eight smaller integers in one.
 * Use any combination of predefined masks to store integers of various sizes,
 * or make your own.
 * @author Pekka Heikkinen
 */
abstract MultiInt(Int)
{
	
	/**
	 * Can store 3 bytes, up to 7
	 */ 
	public static inline var MASK_A:Int = 1879048192;
	
	/**
	 * Can store 7 bytes, up to 63
	 */
	public static inline var MASK_AB:Int = 2130706432;
	
	/**
	 * Can store 11 bytes: up to 1023
	 */
	public static inline var MASK_ABC:Int = 2146435072;
	
	/**
	 *  Can store 4 bytes: up to 15
	 */
	public static inline var MASK_B:Int = 251658240;
	
	/**
	 *  Can store 4 bytes: up to 15
	 */
	public static inline var MASK_C:Int = 15728640;
	
	/**
	 *  Can store 4 bytes: up to 15
	 */
	public static inline var MASK_D:Int = 983040;
	
	/**
	 *  Can store 4 bytes: up to 15
	 */
	public static inline var MASK_E:Int = 61440;
	
	/**
	 *  Can store 4 bytes: up to 15
	 */
	public static inline var MASK_F:Int = 3840;
	
	/**
	 *  Can store 4 bytes: up to 15
	 */
	public static inline var MASK_G:Int = 240;
	
	/**
	 *  Can store 4 bytes: up to 15
	 */
	public static inline var MASK_H:Int = 15;
	
	public inline function new(a=0) 
	{
		this = a;
	}
	
	/**
	 * Store Value into bits marked with Mask.
	 * Bits not within Mask's range will be cut off.
	 * @param	Value
	 * @param	Mask
	 */
	public inline function set(Value:Int, Mask:Int):Void
	{
		var Position:Int = 0;
		this &= ~Mask;
		while (Mask & 1 == 0)
		{
			Mask >>= 1;
			Position++;
		}
		Value &= (Mask & Value);
		Value <<= Position;
		this |= Value;
	}
	
	/**
	 * Gets the integer stored in Mask
	 * @param	Mask
	 * @return	Stored integer
	 */
	public inline function get(Mask:Int):Int
	{
		var Copy:Int = this;
		while (Mask & 1 == 0)
		{
			Mask >>= 1;
			Copy >>= 1;
		}
		Copy &= (Mask & Copy);
		return Copy;
	}
	
	@:to public inline function toInt():Int
	{
		return this;
	}
	
	@:to public inline function toString():String
	{
		var mult:Int = 1;

		var str:String = "";
		for (bit in new IntIterator(0-3, 31-3))
		{
			if (this & mult != 0)
			{
				str = "1" + str;
			}
			else
			{
				str = "0" + str;
			}
			if (bit % 4 == 0)
			{
				str = " " + str;
			}
			mult <<= 1;
		}
		return StringTools.trim(str);
	}
	
}