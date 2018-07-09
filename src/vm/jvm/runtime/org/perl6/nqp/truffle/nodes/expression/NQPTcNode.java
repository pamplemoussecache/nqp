package org.perl6.nqp.truffle.nodes.expression;
import com.oracle.truffle.api.frame.VirtualFrame;
import com.oracle.truffle.api.nodes.NodeInfo;
import org.perl6.nqp.truffle.nodes.NQPNode;
import org.perl6.nqp.truffle.nodes.NQPStrNode;
import org.perl6.nqp.truffle.runtime.StringOps;
import org.perl6.nqp.dsl.Deserializer;

@NodeInfo(shortName = "tc")
public final class NQPTcNode extends NQPStrNode {
    @Child private NQPNode argNode;

    @Deserializer
    public NQPTcNode(NQPNode argNode) {
        this.argNode = argNode;
    }

    @Override
    public String executeStr(VirtualFrame frame) {
        String val = argNode.executeStr(frame);
        String ret = "";
        for (int offset = 0; offset < val.length(); ) {
            int codepoint = val.codePointAt(offset);
            ret += StringOps.codepointToTitleCase(codepoint);
            offset += Character.charCount(codepoint);
        }
        return ret;
    }
}
