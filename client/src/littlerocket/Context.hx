package littlerocket;
import flambe.asset.AssetPack;

/**
 * Used to pass the global things around the application as
 * in the Flambe SHMUP demo. Might be a good idea to refactor something
 * more clever later or keep the contents in bare minimum.
 * @author Tuomas Salmi
 */
class Context
{
	private var pack:AssetPack;
	
	public function new(pack:AssetPack) 
	{
		this.pack = pack;
	}
	
	public function getPack():AssetPack
	{
		return pack;
	}
	
}