Ext.BLANK_IMAGE_URL = './ext/resources/images/default/s.gif';

Ext.onReady(function(){
    // shorthand
    var Tree = Ext.tree;

    var tree = new Tree.TreePanel('tree-div', {
        animate:true,
        loader: new Tree.TreeLoader({dataUrl:'http://localhost:9001/dev/category/category_tree'}), //修改这里
        enableDD:true,
        containerScroll: true
    });

    // set the root node
    var root = new Tree.AsyncTreeNode({
        text: 'Ext JS',
        draggable:false,
        id:'source'
    });
    tree.setRootNode(root);

    // render the tree
    tree.render();
    root.expand();
});

