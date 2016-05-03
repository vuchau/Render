//
//  AlbumComponentView.swift
//  RenderTodoDemo
//
//  Created by Alex Usbergo on 03/05/16.
//  Copyright © 2016 Alex Usbergo. All rights reserved.
//

import UIKit
import Render

extension S.AlbumAppearanceProxy {
    
    var defaultInsets: Inset {
        get {
            let margin = ~S.Album.marginInBetweenElements
            return (0.0, margin, 0.0, margin, margin, margin)
        }
    }
}


extension Album: ComponentStateType {
    
}

class AlbumComponentView: StaticComponentView {
    
    /// the component state
    var album: Album? {
        return self.state as? Album
    }
    
    override func construct() -> ComponentNodeType {
        
        return ComponentNode<UIView>().configure({ view in
            
            let featured = self.album?.featured ?? false
            view.style.flexDirection = featured ? .Column : .Row
            view.backgroundColor = S.Color.black
            view.style.dimensions.width = featured ? ~self.parentSize.width/2 : ~self.parentSize.width
            view.style.dimensions.height = featured ? Undefined : 64

        }).children([
            
            ComponentNode<UIImageView>().configure({ view in
                let featured = self.album?.featured ?? false
                view.image = self.album?.cover
                view.style.alignSelf = .Center
                view.style.dimensions.width = featured ? ~self.parentSize.width/2 : 48
                view.style.dimensions.height = featured ? view.style.dimensions.width : 48
            }),
            
            ComponentNode<UIView>().configure({ view in
                view.style.flexDirection = .Column
                view.style.margin = S.Album.defaultInsets
                view.style.alignSelf = .Center
                
            }).children([
                
                ComponentNode<UILabel>().configure({ view in
                    view.style.margin = S.Album.defaultInsets
                    view.backgroundColor = S.Color.black
                    view.text = self.album?.title ?? "None"
                    view.font = S.Typography.mediumBold
                    view.textColor = S.Color.white
                }),
                
                ComponentNode<UILabel>().configure({ view in
                    view.style.margin = S.Album.defaultInsets
                    view.backgroundColor = S.Color.black
                    view.text = self.album?.artist ?? "Uknown Artist"
                    view.font = S.Typography.extraSmallLight
                    view.textColor = S.Color.white
                })
            ])
        ])
    }
    
}